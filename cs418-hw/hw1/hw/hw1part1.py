import pandas as pd
import numpy as np

def extract_hour(time):
    """
    Extracts hour information from military time.

    Args:
        time (float64): series of time given in military format.
          Takes on values in 0.0-2359.0 due to float64 representation.

    Returns:
        array (float64): series of input dimension with hour information.
          Should only take on integer values in 0-23
    """
    corrected = time.where(time.notna(), np.nan)
    result = []

    for time_val in corrected:
        final_val = None

        if time_val == None:
            final_val = np.nan
        # 1.0 12.0 230.0 1430.0         
        # one digit -> hour        
        if time_val <= 9.0 and time_val >= 0 and final_val == None:
            final_val = time_val
        # two digits -> hours
        if time_val < 24.0 and time_val >= 10.0 and final_val == None:
            final_val = time_val
            
        # three digits
        if time_val >= 100.0 and time_val <= 959.0 and final_val == None:
            final_val = time_val // 100
        
        # 4 digits
        if time_val >= 1000.0 and time_val <= 2359 and final_val == None:
            final_val = time_val // 100
        
        if final_val != None:
            final_val = final_val if final_val >= 0.0 and final_val <= 23.0 else np.nan
            
        result.append(final_val)

    return pd.Series(result, dtype='float64')


    
def extract_mins(time):
    """
    Extracts minute information from military time
    
    Args: 
        time (float64): series of time given in military format.  
          Takes on values in 0.0-2359.0 due to float64 representation.
    
    Returns:
        array (float64): series of input dimension with minute information.  
          Should only take on integer values in 0-59
    """
    corrected = time.where(time.notna(), np.nan)
    result = []

    for time_val in corrected:
        final_val = None
        # 1.0 12.0 230.0 1430.0         
        # one digit -> 0 minutes 

        if time_val == None:
            final_val = np.nan   

        if time_val <= 9.0 and time_val >= 0 and final_val == None:
            final_val = 0.0

        # two digits -> 0 minutes
        if time_val < 24.0 and time_val >= 10.0 and final_val == None:
            final_val = 0.0
            
        # three digits -> last is minute val
        if time_val >= 100.0 and time_val <= 959.0 and final_val == None:
            final_val = time_val % 100
        
        # 4 digits -> last two are minutes
        if time_val >= 1000.0 and time_val <= 2359.0 and final_val == None:
            final_val = time_val % 100
        
        if final_val != None:
            final_val = final_val if final_val >= 0.0 and final_val <= 59.0 else np.nan
            
        result.append(final_val)

    return pd.Series(result, dtype='float64')


def convert_to_minofday(time):
    """
    Converts military time to minute of day
    
    Args:
        time (float64): series of time given in military format.  
          Takes on values in 0.0-2359.0 due to float64 representation.
    
    Returns:
        array (float64): series of input dimension with minute of day
    
    Example: 1:03pm is converted to 783.0
    """
    result = []
    hours_frame = extract_hour(time)
    minutes_frame = extract_mins(time)
    
    # go through each of them in parallel and add up
    for i in range(len(hours_frame)):
        result.append(hours_frame[i]*60.0 + minutes_frame[i])
        
    return pd.Series(result, dtype="float64")


def calc_time_diff(x, y):
    """
    Calculates delay times y - x
    
    Args:
        x (float64): series of scheduled time given in military format.  
          Takes on values in 0.0-2359.0 due to float64 representation.
        y (float64): series of same dimensions giving actual time
    
    Returns:
        array (float64): series of input dimension with delay time
    """
    result = []
    
    scheduled = convert_to_minofday(x)
    actual = convert_to_minofday(y)
    
    for i in range(len(actual)):
        result.append(actual[i] - scheduled[i])
        
    return pd.Series(result, dtype="float64")

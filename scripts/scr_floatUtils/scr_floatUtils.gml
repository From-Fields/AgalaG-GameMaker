// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function math_repeat(value, max_) {
    if(value == 0)
        return 0;

    var remainder = value;

    if(max_ > 0) 
    {
        while(remainder < 0 || remainder > max_)
        {
            if(remainder > max_)
                remainder = 0 - (max_ - remainder);
            if(remainder < 0)
                remainder = max_ + remainder;
        }
    }
    else
    {
        while(remainder < 0 || remainder > max_)
        {
            if(remainder < max_)
                remainder = 0 - (max_ + remainder);
            if(remainder > 0)
                remainder = 0 - remainder;
        }
    }

    return remainder;
}

CREATE OR REPLACE FUNCTION password_rule_checker(new_password varchar,old_password varchar,chars integer := NULL,letter integer := NULL,upper integer := NULL,lower integer := NULL,digit integer := NULL)
RETURN boolean IS   
    digit_array varchar(10) := '0123456789';                                        
    alpha_array varchar(26) := 'abcdefghijklmnopqrstuvwxyz';                        
    cnt_letter integer := 0;                                                        
    cnt_digit integer := 0;                                                         
    cnt_special integer := 0;                                                       
    delimiter boolean := FALSE;                                                     
    len INTEGER := NVL (length(new_password), 0);                                   
    i integer ;                                                                     
    ch CHAR(1);                                                                     
 BEGIN                                                                                                                                          
    FOR i in 1..len LOOP                                                            
       ch := substr(new_password, i, 1);                                            
       IF ch = '"' THEN                                                             
          delimiter := TRUE;                                                        
       ELSIF POSITION(ch IN digit_array) > 0 THEN                                   
          cnt_digit := cnt_digit + 1;                                               
       ELSIF POSITION(lower(ch) IN alpha_array) > 0 THEN                            
          cnt_letter := cnt_letter + 1;                                             
       END IF;                                                                      
    END LOOP;                                                                       
                                                                                    
     IF substring(new_password FROM old_password) IS NOT NULL                       
   THEN                                                                             
     RAISE EXCEPTION 'New password cannot include old password';                    
   END IF;                                                                          
                                                                                    
    IF delimiter = TRUE THEN                                                        
       RAISE EXCEPTION 'Password cannot contain a double-quote character';          
    END IF;                                                                         
                                                                                    
    IF chars IS NOT NULL AND len < chars THEN                                       
       RAISE EXCEPTION 'Password length less than % ', chars;                       
    END IF;                                                                         
                                                                                    
    IF letter IS NOT NULL AND cnt_letter < letter THEN                              
       RAISE EXCEPTION 'Password must contain at least % letter(s)', letter;        
    END IF;                                                                         
                                                                                    
    IF digit IS NOT NULL AND cnt_digit < digit THEN                                 
       RAISE EXCEPTION 'Password must contain at least % digit(s)', digit;          
    END IF;                                                                         
                                                                                    
    RETURN(TRUE);                                                                   
 END;
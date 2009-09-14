


    select * from movcontasapagar
    where i_emp_fil = 11
    and i_lan_apg in ( select i_lan_apg from cadcontasapagar where
                       i_emp_fil = 11 
                       and c_cla_pla = 'xxxxxxxx') 


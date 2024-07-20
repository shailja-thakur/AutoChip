module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer,
    output keep_driving,
    output shut_off_car
);

    reg keep_driving;
    reg shut_off_car;
    
    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1;
        else
            shut_off_computer = 0;
    end
    
    always @(*) begin
        if (!arrived) 
            keep_driving = !gas_tank_empty;
        else
            keep_driving = 0;
    end

endmodule

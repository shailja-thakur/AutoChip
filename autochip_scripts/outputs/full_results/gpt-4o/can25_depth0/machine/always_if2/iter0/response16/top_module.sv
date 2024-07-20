module top_module (
    input wire cpu_overheated,
    input wire arrived,
    input wire gas_tank_empty,
    output reg shut_off_computer,
    output reg keep_driving
);

    // Control "shut_off_computer" output 
    always @ (cpu_overheated) begin
        if (cpu_overheated)
            shut_off_computer <= 1;
        else
            shut_off_computer <= 0;
    end

    // Control "keep_driving" output 
    always @ (arrived or gas_tank_empty) begin
        if (!arrived)
            keep_driving <= !gas_tank_empty;
        else
            keep_driving <= 0;
    end

endmodule

module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); //

    // Fix the bug in teh following code
    
    always @(*) begin
        if (cpu_overheated && !arrived)
           shut_off_computer = 1;
    end

    always @(*) begin
        if (arrived || gas_tank_empty)
           keep_driving = 1;
    end

endmodule
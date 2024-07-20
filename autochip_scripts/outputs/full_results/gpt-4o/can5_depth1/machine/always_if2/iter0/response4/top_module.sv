module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer,
    output reg keep_driving
);

    reg c_shut_off_computer;

    // Control shut_off_computer output
    always @(*) begin
        if (cpu_overheated) begin
            c_shut_off_computer = 1;
        end else begin
            c_shut_off_computer = 0;
        end
    end
    
    // Assign to the actual output
    assign shut_off_computer = c_shut_off_computer;

    // Control keep_driving output
    always @(*) begin
        if (!arrived) begin
            keep_driving = ~gas_tank_empty;
        end else begin
            keep_driving = 0;
        end
    end

endmodule

module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer,
    output reg keep_driving
);
    // Internal register for shut_off_computer control
    reg shut_off_computer_internal;

    // First always block to control shut_off_computer output
    always @(*) begin
        if (cpu_overheated) begin
            shut_off_computer_internal = 1;
        end else begin
            shut_off_computer_internal = 0;
        end
    end

    // Assign the internal register to the output
    assign shut_off_computer = shut_off_computer_internal;

    // Second always block to control keep_driving output
    always @(*) begin
        if (arrived) begin
            keep_driving = 0;
        end else begin
            keep_driving = ~gas_tank_empty;
        end
    end
endmodule

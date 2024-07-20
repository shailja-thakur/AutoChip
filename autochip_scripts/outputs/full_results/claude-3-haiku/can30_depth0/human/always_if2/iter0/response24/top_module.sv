module top_module (
    input cpu_overheated,
    output reg shut_off_computer,
    input arrived,
    input gas_tank_empty,
    output reg keep_driving
);

    always @(*) begin
        // Correct the assignment to shut_off_computer
        shut_off_computer = cpu_overheated;
    end

    always @(*) begin
        // Correct the logic for keep_driving
        keep_driving = arrived ? 0 : ~gas_tank_empty;
    end

endmodule

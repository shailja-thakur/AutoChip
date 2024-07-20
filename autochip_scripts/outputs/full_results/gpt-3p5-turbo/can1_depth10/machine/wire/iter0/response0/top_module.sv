module top_module(
    input wire clk,
    input wire rst,
    output reg out
);

    // Internal signals
    reg [1:0] state;
    reg [7:0] counter;

    // Outputs
    reg [7:0] data_out;
    reg valid;

    // State definitions
    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;

    // Initialize signals
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 8'b0;
            valid <= 0;
        end else begin
            case(state)
                IDLE: begin
                    counter <= 0;
                    data_out <= 8'b0;
                    valid <= 0;
                    if (in) begin
                        state <= WAIT;
                    end
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    valid <= 0;
                    if (counter == 8'd10) begin
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_out <= in;
                    valid <= 0;
                    state <= DONE;
                end
                DONE: begin
                    valid <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end

    // Output assignment
    always @(state or data_out or valid) begin
        if (state == DONE) begin
            out <= data_out;
        end else begin
            out <= 0;
        end
    end

endmodule

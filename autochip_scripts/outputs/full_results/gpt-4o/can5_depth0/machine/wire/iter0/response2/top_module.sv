module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,  // Assuming 8-bit data output
    output reg valid_out
);

    reg [1:0] state;
    reg [7:0] counter;  // Assuming counter is 8-bit

    // State Definitions
    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;

    // State Machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    if (counter == 8'd255) begin  // Assuming threshold is 255
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_out <= 8'hAA;  // Assuming processing sets data_out to 0xAA
                    state <= DONE;
                end
                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule

module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid
);

    // Internal signals
    reg [1:0] state; // 2-bit state register since we have 4 states
    reg [3:0] counter; // 4-bit counter for counting clock cycles

    // State definitions
    localparam IDLE    = 2'b00,
               WAIT    = 2'b01,
               PROCESS = 2'b10,
               DONE    = 2'b11;

    // FSM process
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // When reset is asserted
            state <= IDLE;
            counter <= 4'd0;
            data_out <= 8'd0;
            valid <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'd0;
                    data_out <= 8'd0;
                    valid <= 1'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1'b1;
                    data_out <= 8'd0;
                    valid <= 1'b0;
                    if (counter == 4'd15) begin // Assuming threshold is 15 clock cycles
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    // Processed data (example: counting cycles)
                    data_out <= counter;
                    valid <= 1'b0;
                    state <= DONE;
                end
                DONE: begin
                    valid <= 1'b1;
                    state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end

endmodule

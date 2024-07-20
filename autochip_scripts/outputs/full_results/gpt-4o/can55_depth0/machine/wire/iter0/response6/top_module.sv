module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Declare internal signals
    reg [1:0] state;
    reg [3:0] counter;

    // State encoding
    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;

    // Always block to implement the FSM
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 0;
                    data_out <= 0;
                    valid_out <= 0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 0;
                    if (counter == 4'b1111) begin // Threshold condition for the example
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_out <= 8'hAA; // Assume 8'hAA as the data being processed
                    state <= DONE;
                end
                DONE: begin
                    valid_out <= 1;
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule

module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define the states
    parameter IDLE = 2'b00;
    parameter SEARCH_1 = 2'b01;
    parameter SEARCH_2 = 2'b10;
    parameter SEARCH_3 = 2'b11;

    // Declare the state register
    reg [1:0] state, next_state;

    // State transitions
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = SEARCH_1;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SEARCH_1: begin
                if (data == 1'b1) begin
                    next_state = SEARCH_2;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SEARCH_2: begin
                if (data == 1'b0) begin
                    next_state = SEARCH_3;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SEARCH_3: begin
                if (data == 1'b1) begin
                    next_state = IDLE;
                    start_shifting = 1'b1; // Set start_shifting to 1 when the sequence is found
                end
                else begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule

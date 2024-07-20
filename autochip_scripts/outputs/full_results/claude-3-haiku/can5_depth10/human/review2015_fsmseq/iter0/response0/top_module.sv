module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the FSM
localparam [1:0] IDLE = 2'b00, SEARCHING = 2'b01, FOUND = 2'b10;

// Internal state register
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= SEARCHING;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            SEARCHING: begin
                if (data == 1'b1) begin
                    state <= SEARCHING;
                end
                else if (data == 1'b0) begin
                    state <= IDLE;
                end
                else begin
                    state <= FOUND;
                end
                start_shifting <= 1'b0;
            end
            FOUND: begin
                state <= FOUND;
                start_shifting <= 1'b1;
            end
            default: begin
                state <= IDLE;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule

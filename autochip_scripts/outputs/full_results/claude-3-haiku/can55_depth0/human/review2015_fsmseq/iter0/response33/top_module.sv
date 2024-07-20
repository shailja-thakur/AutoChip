module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] SEARCH = 2'b00, FOUND = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= SEARCH;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        SEARCH: begin
            start_shifting = 1'b0;
            if (data == 1'b1) begin
                next_state = FOUND;
            end else begin
                next_state = SEARCH;
            end
        end
        FOUND: begin
            start_shifting = 1'b1;
            next_state = FOUND;
        end
        default: begin
            start_shifting = 1'b0;
            next_state = SEARCH;
        end
    endcase
end

endmodule

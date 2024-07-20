module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state, j, k) begin
    case (state)
        A: begin
            if (j) begin
                next_state = B;
            end else begin
                next_state = A;
            end 
        end
        B: begin
            if (k) begin
                next_state = A;
            end else begin
                next_state = B;
            end 
        end
        default: next_state = A;
    end
end

always @(state) begin
    if (state == B) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end 
end

endmodule

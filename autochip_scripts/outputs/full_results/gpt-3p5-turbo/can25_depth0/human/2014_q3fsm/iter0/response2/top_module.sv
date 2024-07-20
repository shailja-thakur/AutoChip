module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
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

always @(state or w) begin
    case(state)
        A: begin
            if (s) begin
                next_state <= B;
            end else begin
                next_state <= A;
            end
        end
        B: begin
            if (w == 2'b11) begin
                next_state <= A;
                z <= 1;
            end else begin
                next_state <= B;
                z <= 0;
            end
        end
    endcase
end

endmodule

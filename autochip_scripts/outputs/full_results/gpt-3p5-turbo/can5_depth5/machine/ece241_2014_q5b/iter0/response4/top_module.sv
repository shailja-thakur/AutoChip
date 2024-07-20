module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter A = 0;
parameter B = 1;

reg state;
wire detect_rising_edge;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= A;
    end else begin
        case (state)
            A: begin
                if (x == 1) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            B: begin
                state <= B;
            end
        endcase
    end
end

assign detect_rising_edge = ((state == A) && (x == 1)) || ((state == B) && (x == 0));
assign z = detect_rising_edge;

endmodule

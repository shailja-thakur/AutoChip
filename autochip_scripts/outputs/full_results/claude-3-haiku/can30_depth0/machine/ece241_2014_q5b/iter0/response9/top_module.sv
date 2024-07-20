module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (~x) begin
                    state <= B;
                end
                else begin
                    state <= B;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

assign z = (state == A && x) || (state == B && ~x);

endmodule
module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (~x) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

assign z = (state == A && x) || (state == B && ~x);

endmodule

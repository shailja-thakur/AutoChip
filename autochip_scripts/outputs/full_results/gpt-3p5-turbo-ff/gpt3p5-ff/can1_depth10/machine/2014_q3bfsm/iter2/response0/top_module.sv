module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        case(state)
            A: begin
                if (x) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            B: begin
                if (x) begin
                    state <= D;
                end else begin
                    state <= C;
                end
            end
            C: begin
                if (x) begin
                    state <= B;
                end else begin
                    state <= C;
                end
            end
            D: begin
                if (x) begin
                    state <= C;
                end else begin
                    state <= B;
                end
            end
            E: begin
                if (x) begin
                    state <= E;
                end else begin
                    state <= D;
                end
            end
        endcase
    end
end

always @(state) begin
    if (state == D || state == E) begin
        z <= 1;
    end else begin
        z <= 0;
    end
end

endmodule

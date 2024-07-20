module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        A: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (in) begin
                next_state = C;
            end else begin
                next_state = B;
            end
        end
        C: begin
            if (in) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        D: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
    endcase
end

always @(posedge clk) begin
    if (state == D) begin
        out <= 1;
    end else begin
        out <= 0;
    end
end

endmodule

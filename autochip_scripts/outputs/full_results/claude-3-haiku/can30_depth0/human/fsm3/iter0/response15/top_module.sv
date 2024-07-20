module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] current_state, next_state;

localparam [1:0] 
    A = 2'd0,
    B = 2'd1, 
    C = 2'd2,
    D = 2'd3;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        A: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
            out = 1'b0;
        end
        B: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
            out = 1'b0;
        end
        C: begin
            if (in) begin
                next_state = D;
            end
            else begin
                next_state = A;
            end
            out = 1'b0;
        end
        D: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
            out = 1'b1;
        end
        default: begin
            next_state = A;
            out = 1'b0;
        end
    endcase
end

endmodule

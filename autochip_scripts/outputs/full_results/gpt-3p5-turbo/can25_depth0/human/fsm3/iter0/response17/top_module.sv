module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] current_state, next_state;
parameter A = 0, B = 1, C = 2, D = 3;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

always @(current_state, in) begin
    case (current_state)
        A: begin
            if (in) begin
                next_state <= B;
            end else begin
                next_state <= A;
            end
            out <= 0;
        end
        
        B: begin
            if (in) begin
                next_state <= B;
            end else begin
                next_state <= C;
            end
            out <= 0;
        end
        
        C: begin
            if (in) begin
                next_state <= D;
            end else begin
                next_state <= A;
            end
            out <= 0;
        end
        
        D: begin
            if (in) begin
                next_state <= B;
            end else begin
                next_state <= C;
            end
            out <= 1;
        end
    endcase
end

endmodule

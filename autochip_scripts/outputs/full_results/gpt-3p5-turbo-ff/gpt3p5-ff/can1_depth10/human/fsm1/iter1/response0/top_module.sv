module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;

    parameter A = 2'b00;
    parameter B = 2'b01;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state or in) begin
        case (state)
            A: begin
                if (in) begin
                    next_state <= A;
                end else begin
                    next_state <= B;
                end
                out <= 1'b0;
            end
            
            B: begin
                if (in) begin
                    next_state <= B;
                end else begin
                    next_state <= A;
                end
                out <= 1'b1;
            end
        endcase
    end

endmodule

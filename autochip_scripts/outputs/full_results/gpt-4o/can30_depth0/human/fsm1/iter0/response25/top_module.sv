module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            B: begin
                next_state = (in == 1'b0) ? A : B;
                out = 1'b1;
            end
            A: begin
                next_state = (in == 1'b0) ? B : A;
                out = 1'b0;
            end
            default: begin
                next_state = B;
                out = 1'b1;
            end
        endcase
    end
    
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end
    
endmodule

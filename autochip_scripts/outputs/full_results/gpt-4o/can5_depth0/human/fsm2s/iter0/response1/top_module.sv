module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [0:0] {OFF = 1'b0, ON = 1'b1} state_t;
    state_t state, next_state;

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            OFF: begin
                if (j) 
                    next_state = ON;
                else 
                    next_state = OFF;
                out = 1'b0;
            end
            ON: begin
                if (k) 
                    next_state = OFF;
                else 
                    next_state = ON;
                out = 1'b1;
            end
            default: begin
                next_state = OFF;
                out = 1'b0;
            end
        endcase
    end
endmodule

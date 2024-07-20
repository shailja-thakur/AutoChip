module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg z;
    reg state, next_state;
    parameter INIT = 1'b0, COMPLEMENT = 1'b1;

    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= INIT;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            INIT: begin
                if (areset)
                    next_state = INIT;
                else
                    next_state = COMPLEMENT;
                z = 1'b0;
            end
            COMPLEMENT: begin
                z = ~x; // Complement the input bit
                next_state = COMPLEMENT;
            end
            default: begin
                next_state = INIT; // Default state
            end
        endcase
    end
endmodule

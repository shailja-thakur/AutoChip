module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    reg state, next_state;

    // State transition on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = B;
            end
            default: begin
                next_state = A;  // Default state in case of invalid state
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: begin
                z = x;
            end
            B: begin
                z = ~x;
            end
            default: begin
                z = 1'b0;
            end
        endcase
    end

endmodule

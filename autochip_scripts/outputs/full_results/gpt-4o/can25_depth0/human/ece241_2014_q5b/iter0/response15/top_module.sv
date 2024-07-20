module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // States are encoded as one-hot
    reg [1:0] state, next_state;
    parameter A = 2'b01;
    parameter B = 2'b10;

    // State transition on clock edge or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // Asynchronous reset to state A
        else
            state <= next_state;
    end

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            default: begin
                next_state = A; // Default state in case of invalid state
                z = 0;
            end
        endcase
    end
    
endmodule

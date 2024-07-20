module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // encoding states as one-hot
    reg [1:0] state, next_state;
    localparam A = 2'b01, B = 2'b10;
    
    // state transition
    always @(*) begin
        case (state)
            A: begin
                if (x == 0) begin
                    next_state = A;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            B: begin
                if (x == 0) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = B;
                    z = 0;
                end
            end
        endcase
    end
    
    // state register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // reset to state A
        else
            state <= next_state;
    end

endmodule

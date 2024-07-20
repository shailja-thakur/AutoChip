module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [2:0] state;
    reg [2:0] next_state;
    wire conversion_done;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 3'b000;
        else
            state <= next_state;
    end
    
    always @(state, x) begin
        case (state)
            3'b000: begin
                if (x)
                    next_state = 3'b001;
                else
                    next_state = 3'b000;
                z <= x;
            end
            3'b001: begin
                if (x)
                    next_state = 3'b010;
                else
                    next_state = 3'b001;
                z <= ~x;
            end
            3'b010: begin
                if (x)
                    next_state = 3'b011;
                else
                    next_state = 3'b010;
                z <= ~x;
            end
            3'b011: begin
                next_state = 3'b011;
                z <= z;
            end
        endcase
    end
    
endmodule

module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [2:0] state, state_next;
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= 3'b000;
        else
            state <= state_next;
    end
    
    always @* begin
        case (state)
            3'b000:
                if (x)
                    state_next = 3'b010;
                else
                    state_next = 3'b000;
            3'b010:
                if (x)
                    state_next = 3'b010;
                else
                    state_next = 3'b001;
            3'b001:
                if (x)
                    state_next = 3'b010;
                else
                    state_next = 3'b000;
        endcase
    end
    
    always @(posedge clk) begin
        case (state)
            3'b000, 3'b010:
                z <= 1'b0;
            3'b001:
                z <= x;
        endcase
    end
    
endmodule

module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [3:0] state, state_next;
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= 4'b0000;
        else
            state <= state_next;
    end
    
    always @* begin
        case (state)
            4'b0000:
                if (x)
                    state_next = 4'b0010;
                else
                    state_next = 4'b0000;
            4'b0010:
                if (x)
                    state_next = 4'b0001;
                else
                    state_next = 4'b0000;
            4'b0001:
                if (x)
                    state_next = 4'b0010;
                else
                    state_next = 4'b0010;
        endcase
    end
    
    always @(posedge clk) begin
        case (state)
            4'b0000, 4'b0010:
                z <= 1'b0;
            4'b0001:
                z <= x;
        endcase
    end
    
endmodule

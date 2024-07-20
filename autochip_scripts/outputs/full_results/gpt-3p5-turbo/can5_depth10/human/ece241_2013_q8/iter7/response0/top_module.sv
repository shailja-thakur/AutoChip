module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    
    reg [1:0] state;
    reg prev_x;
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else begin
            case (state)
                S0: begin
                    if (x && !prev_x)
                        state <= S1;
                end
                
                S1: begin
                    if (x && !prev_x)
                        state <= S2;
                end
                
                S2: begin
                    if (!x && prev_x)
                        state <= S0;
                end
            endcase
        end
    end
    
    always @(state) begin
        if (state == S2)
            z <= 1'b1;
        else
            z <= 1'b0;
    end
    
    assign prev_x = x;
    
endmodule

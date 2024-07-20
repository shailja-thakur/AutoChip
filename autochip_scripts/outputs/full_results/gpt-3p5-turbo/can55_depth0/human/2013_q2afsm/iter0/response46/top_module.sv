module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    
    // State declaration
    reg [3:0] state;
    
    // Next state logic
    always @(posedge clk or negedge resetn) begin
        if(!resetn)
            state <= 4'b000;
        else begin
            case(state)
                4'b000: begin
                    if(r[1] == 1'b1)
                        state <= 4'b001;
                    else if(r[2] == 1'b1)
                        state <= 4'b010;
                    else if(r[3] == 1'b1)
                        state <= 4'b100;
                    else
                        state <= 4'b000;
                end
                4'b001: begin
                    if(r[1] == 1'b1)
                        state <= 4'b001;
                    else
                        state <= 4'b000;
                end
                4'b010: begin
                    if(r[2] == 1'b1)
                        state <= 4'b010;
                    else
                        state <= 4'b000;
                end
                4'b100: begin
                    if(r[1] == 1'b1)
                        state <= 4'b001;
                    else if(r[2] == 1'b1)
                        state <= 4'b010;
                    else if(r[3] == 1'b1)
                        state <= 4'b100;
                    else
                        state <= 4'b000;
                end
            endcase
        end
    end
    
    // Output logic
    always @(state) begin
        g[1] = (state == 4'b001 || state == 4'b010) ? 1'b1 : 1'b0;
        g[2] = (state == 4'b010) ? 1'b1 : 1'b0;
        g[3] = (state == 4'b100) ? 1'b1 : 1'b0;
    end
    
endmodule

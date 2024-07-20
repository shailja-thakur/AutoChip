module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [7:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
        	state <= 0;
        else begin
            case (state)
                0: if (in[2]) state <= 1;
                1: state <= 2;
                2: state <= 3;
                3: if (in[2]) state <= 1;
            endcase
        end
    end
    
    assign done = (state == 3);

endmodule

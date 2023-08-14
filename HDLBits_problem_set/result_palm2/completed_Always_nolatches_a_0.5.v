module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 

    // Insert your code here

    always @(posedge clk) begin
        case(scancode[15:0])
            16'he06b: left <= 1'b1;
            16'he072: down <= 1'b1;
            16'he074: right <= 1'b1;
            16'he075: up <= 1'b1;
            default: ;
        endcase
    end

endmodule
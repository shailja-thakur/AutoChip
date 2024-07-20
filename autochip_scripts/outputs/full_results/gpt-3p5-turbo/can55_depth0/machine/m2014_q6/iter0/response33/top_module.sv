module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
    reg [2:0] state;
    wire w_low = ~w;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: state <= w_low ? 3'b101 : 3'b000;
                3'b001: state <= w_low ? 3'b100 : 3'b010;
                3'b010: state <= w_low ? 3'b100 : 3'b011;
                3'b011: state <= w_low ? 3'b101 : 3'b100;
                3'b100: state <= w_low ? 3'b001 : 3'b010;
                3'b101: state <= w_low ? 3'b011 : 3'b100;
                default: state <= 3'b000;
            endcase
        end
    end
    
    assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;
    
endmodule

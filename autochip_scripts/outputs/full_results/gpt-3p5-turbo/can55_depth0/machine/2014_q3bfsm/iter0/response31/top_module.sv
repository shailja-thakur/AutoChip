module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
always @(posedge clk or posedge reset) begin
    if(reset) 
        state <= 3'b0;
    else begin
        case(state)
            3'b000: begin
                if(x) state <= 3'b001;
                else state <= 3'b000;
            end
            3'b001: begin
                if(x) state <= 3'b100;
                else state <= 3'b001;
            end
            3'b010: begin
                if(x) state <= 3'b001;
                else state <= 3'b010;
            end
            3'b011: begin
                if(x) state <= 3'b100;
                else state <= 3'b011;
            end
            3'b100: begin
                if(x) state <= 3'b011;
                else state <= 3'b100;
            end
            default: state <= 3'b000;
        endcase
    end
end

always @(state) begin
    if(state == 3'b100 || state == 3'b101) z <= 1'b1;
    else z <= 1'b0;
end

endmodule

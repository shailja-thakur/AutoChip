module top_module (
    input [6:1] y,
    input w,
    output wire Y2,
    output wire Y4
);

    reg [1:0] state;

    always @(*) begin
        case(y)
            7'b000001: state = 2'b00;
            7'b000010: state = 2'b01;
            7'b000100: state = 2'b10;
            7'b001000: state = 2'b11;
            7'b010000: state = 2'b01;
            7'b100000: state = 2'b10;
            default: state = 2'b00;
        endcase
    end
    
    always @(posedge w) begin
        case(state)
            2'b00: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
            2'b01: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
            2'b10: begin
                Y2 = 1'b0;
                Y4 = 1'b1;
            end
            2'b11: begin
                Y2 = 1'b1;
                Y4 = 1'b0;
            end
            default: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        endcase
    end
    
endmodule

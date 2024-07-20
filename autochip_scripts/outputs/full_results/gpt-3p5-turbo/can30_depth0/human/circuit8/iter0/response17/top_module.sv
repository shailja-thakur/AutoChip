module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);
    reg [1:0] state;
    
    always @(posedge clock) begin
        case(state)
            2'b00: begin
                if (a == 0)
                    state <= 2'b00; // no change
                else
                    state <= 2'b01;
            end
            2'b01: begin
                if (a == 0)
                    state <= 2'b10;
                else
                    state <= 2'b01; // no change
            end
            2'b10: begin
                if (a == 0)
                    state <= 2'b10; // no change
                else
                    state <= 2'b11;
            end
            2'b11: begin
                state <= 2'b00;
            end
            default: state <= 2'b00;
        endcase
    end
    
    always @(state) begin
        case(state)
            2'b00: begin
                p <= 1'b0;
                q <= 1'b0;
            end
            2'b01: begin
                p <= 1'b0;
                q <= 1'b1;
            end
            2'b10: begin
                p <= 1'b1;
                q <= 1'b1;
            end
            2'b11: begin
                p <= 1'b0;
                q <= 1'b1;
            end
            default: begin
                p <= 1'b0;
                q <= 1'b0;
            end
        endcase
    end
endmodule

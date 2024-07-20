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
                if (a == 0) begin
                    p <= 0;
                    q <= 0;
                    state <= 2'b00;
                end
                else begin
                    p <= 1;
                    q <= 0;
                    state <= 2'b01;
                end
            end
            
            2'b01: begin
                if (a == 0) begin
                    p <= 1;
                    q <= 0;
                    state <= 2'b10;
                end
                else begin
                    p <= 0;
                    q <= 0;
                    state <= 2'b01;
                end
            end
            
            2'b10: begin
                if (a == 0) begin
                    p <= 0;
                    q <= 1;
                    state <= 2'b11;
                end
                else begin
                    p <= 0;
                    q <= 0;
                    state <= 2'b01;
                end
            end
            
            2'b11: begin
                if (a == 0) begin
                    p <= 0;
                    q <= 1;
                    state <= 2'b11;
                end
                else begin
                    p <= 1;
                    q <= 1;
                    state <= 2'b10;
                end
            end
        endcase
    end
endmodule

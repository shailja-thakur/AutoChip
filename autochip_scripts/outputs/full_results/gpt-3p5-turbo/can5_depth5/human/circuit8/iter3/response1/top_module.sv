module top_module (
    input wire clock,
    input wire a, 
    output reg p,
    output reg q
);

reg [1:0] state;

always @(posedge clock) begin
    case(state)
        2'b00:
            begin
                p <= 1'b0;
                q <= 1'b0;
                if(a == 1'b1)
                    state <= 2'b01;
            end
        2'b01:
            begin
                p <= a;
                q <= a;
                if(a == 1'b0)
                    state <= 2'b00;
            end
    endcase
end

endmodule

module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    case({p,q,a})
        {0,0,0}: begin
            p <= 0;
            q <= 0;
        end
        {0,0,1}: begin
            p <= 0;
            q <= 0;
        end
        {0,1,0}: begin
            p <= 0;
            q <= 0;
        end
        {0,1,1}: begin
            p <= 0;
            q <= 0;
        end
        {1,0,0}: begin
            p <= 0;
            q <= 0;
        end
        {1,0,1}: begin
            p <= 0;
            q <= 0;
        end
        {1,1,0}: begin
            p <= 1;
            q <= 0;
        end
        {1,1,1}: begin
            p <= 1;
            q <= 0;
        end
    endcase
end

endmodule

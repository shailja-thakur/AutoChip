module top_module (
    input [254:0] in,
    output [7:0] out
);
    
    integer i;
    reg [7:0] count; // Temporary register to hold the count value

    always @(*) begin
        count = 8'b0; // Initialize count to zero
        for (i = 0; i < 255; i = i + 1) begin
            if (in[i]) begin
                count = count + 1;
            end
        end
    end

    assign out = count; // Assign the count value to the output

endmodule

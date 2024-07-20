module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);
    
    wire [7:0] selExtended;
    reg [7:0] counter;
    
    assign selExtended = sel + counter;
    always @(posedge clk) begin
        if (sel <= 245) begin
            counter <= counter + 1;
        end else begin
            counter <= 0;
        end
    end
    
    assign out = in[selExtended];
    
endmodule

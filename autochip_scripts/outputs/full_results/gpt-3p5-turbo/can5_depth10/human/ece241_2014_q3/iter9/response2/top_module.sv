module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);
    
    wire a, b;

    assign a = c & (~d);
    assign b = ~c & d;

    // Implementing the 4-to-1 mux
    always @(a, b, c, d) begin
        case ({a, b})
            2'b00: mux_in = 4'b1;
            2'b01: mux_in = 4'b0;
            2'b11: mux_in = 4'b1;
            2'b10: mux_in = 4'b1;
        endcase
    end

endmodule

module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

    reg [15:0] q_temp; // Temporary variable to hold the output values before applying byte enable

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            q_temp <= 16'd0; // Reset all flip-flops to 0
        end else begin
            // Write to the individual bytes based on byte enable signals
            if (byteena[0])
                q_temp[7:0] <= d[7:0];
            if (byteena[1])
                q_temp[15:8] <= d[15:8];
        end
    end

    // Assign q as the output after applying byte enable
    assign q = (byteena[1]) ? (byteena[0]) ? q_temp : {8'd0, q_temp[7:0]} : (byteena[0]) ? {q_temp[15:8], 8'd0} : q_temp;

endmodule

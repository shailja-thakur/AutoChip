module top_module(
    input [3:0] y,
    input w,
    output reg Y2
);

    always @(*) begin
        case ({y, w})
            {4'h0, 1'b0}: Y2 = 0;
            {4'h1, 1'b0}: Y2 = 0;
            {4'h2, 1'b0}: Y2 = 1;
            {4'h3, 1'b0}: Y2 = 1;
            {4'h4, 1'b0}: Y2 = 0;
            {4'h5, 1'b0}: Y2 = 1;
            {4'h6, 1'b0}: Y2 = 0;
            {4'h7, 1'b0}: Y2 = 0;
            {4'h8, 1'b0}: Y2 = 0;
            {4'h9, 1'b0}: Y2 = 1;
            {4'hA, 1'b0}: Y2 = 1;
            {4'hB, 1'b0}: Y2 = 1;
            default: Y2 = 0;
        endcase
    end

endmodule

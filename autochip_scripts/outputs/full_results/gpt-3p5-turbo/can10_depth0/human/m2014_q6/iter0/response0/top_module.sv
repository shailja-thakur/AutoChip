module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
    end else begin
        case (state)
            0: begin
                if (w) begin
                    state <= 0;
                end else begin
                    state <= 1;
                end
            end
            
            1: begin
                if (w) begin
                    state <= 3;
                end else begin
                    state <= 2;
                end
            end
            
            2: begin
                if (w) begin
                    state <= 4;
                end else begin
                    state <= 3;
                end
            end
            
            3: begin
                if (w) begin
                    state <= 0;
                end else begin
                    state <= 5;
                end
            end
            
            4: begin
                if (w) begin
                    state <= 6;
                end else begin
                    state <= 5;
                end
            end
            
            5: begin
                if (w) begin
                    state <= 5;
                end else begin
                    state <= 3;
                end
            end
            
            6: begin
                if (w) begin
                    state <= 2;
                end else begin
                    state <= 3;
                end
            end
        endcase
    end
end

always @* begin
    case (state)
        0: z = 1'b0;
        1: z = 1'b0;
        2: z = 1'b0;
        3: z = 1'b0;
        4: z = 1'b0;
        5: z = 1'b1;
        6: z = 1'b1;
    endcase
end

endmodule

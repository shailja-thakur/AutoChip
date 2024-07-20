module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State register
    reg [2:0] state;
    
    // State definitions
    localparam S = 3'b000;
    localparam S1 = 3'b001;
    localparam S11 = 3'b011;
    localparam S110 = 3'b110;
    localparam Done = 3'b111;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S;
        end else begin
            case (state)
                S: begin
                    if (data) begin
                        state <= S1;
                    end else begin
                        state <= S;
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S11;
                    end else begin
                        state <= S;
                    end
                end
                S11: begin
                    if (data) begin
                        state <= S11;
                    end else begin
                        state <= S110;
                    end
                end
                S110: begin
                    if (data) begin
                        state <= Done;
                    end else begin
                        state <= S;
                    end
                end
                Done: begin
                    state <= Done;
                end
            endcase
        end
    end

    // Output assignment
    always @(*) begin
        start_shifting = (state == Done);
    end

endmodule

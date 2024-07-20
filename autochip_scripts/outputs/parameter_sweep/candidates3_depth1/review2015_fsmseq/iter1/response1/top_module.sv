module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg start_sequence_found; // added

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            start_shifting <= 0;
            start_sequence_found <= 0; // added
        end else begin
            case (state)
                4'b0000: begin
                    if (data) begin
                        state <= 4'b0001;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0001: begin
                    if (data) begin
                        state <= 4'b0010;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0010: begin
                    if (data) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0011: begin
                    if (data) begin
                        state <= 4'b0011;
                        start_sequence_found <= 1; // added
                    end else begin
                        state <= 4'b0000;
                        start_sequence_found <= 1; // added
                    end
                end
                default: begin
                    state <= 4'b0000;
                    start_shifting <= 0;
                    start_sequence_found <= 0; // added
                end
            endcase
        end
    end
    
    // After reset, set start_shifting to 0 if the sequence is not found
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            start_shifting <= 0;
        end else begin
            start_shifting <= start_sequence_found;
        end
    end
    
endmodule

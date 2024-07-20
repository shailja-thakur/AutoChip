module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);
    
    reg [2:0] state;
    reg disc_out;
    reg flag_out;
    reg err_out;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b100;
            disc_out <= 1'b0;
            flag_out <= 1'b0;
            err_out <= 1'b0;
        end else begin
            case (state)
                3'b100: begin
                    if (in) begin
                        state <= 3'b010;
                        disc_out <= 1'b0;
                        flag_out <= 1'b0;
                        err_out <= 1'b0;
                    end else begin
                        state <= 3'b100;
                        disc_out <= 1'b0;
                        flag_out <= 1'b0;
                        err_out <= 1'b0;
                    end
                end
                3'b010: begin
                    if (in) begin
                        state <= 3'b001;
                        disc_out <= 1'b0;
                        flag_out <= 1'b0;
                        err_out <= 1'b0;
                    end else begin
                        state <= 3'b010;
                        disc_out <= 1'b0;
                        flag_out <= 1'b0;
                        err_out <= 1'b0;
                    end
                end
                3'b001: begin
                    if (in) begin
                        state <= 3'b110;
                        disc_out <= 1'b0;
                        flag_out <= 1'b0;
                        err_out <= 1'b0;
                    end else begin
                        state <= 3'b100;
                        disc_out <= 1'b0;
                        flag_out <= 1'b0;
                        err_out <= 1'b0;
                    end
                end
                3'b110: begin
                    if (in) begin
                        state <= 3'b111;
                        disc_out <= 1'b0;
                        flag_out <= 1'b1;
                        err_out <= 1'b0;
                    end else begin
                        state <= 3'b010;
                        disc_out <= 1'b0;
                        flag_out <= 1'b0;
                        err_out <= 1'b0;
                    end
                end
                3'b111: begin
                    if (in) begin
                        state <= 3'b111;
                        disc_out <= 1'b0;
                        flag_out <= 1'b0;
                        err_out <= 1'b1;
                    end else begin
                        state <= 3'b100;
                        disc_out <= 1'b1;
                        flag_out <= 1'b0;
                        err_out <= 1'b0;
                    end
                end
            endcase
        end
    end
    
    assign disc = disc_out;
    assign flag = flag_out;
    assign err = err_out;
    
endmodule

module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [3:0] shift_data;
    
    integer mismatch_count;
    integer sample_count;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1'b1)
                        state <= 1;
                end
                1: begin
                    if (data == 1'b1)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (data == 1'b0)
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    if (data == 1'b1) begin
                        state <= 0;
                        start_shifting <= 1;
                    end else
                        state <= 0;
                end
                default: state <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (start_shifting) begin
            shift_data <= data;
        end
    end
    
    // Check for matched sequence
    always @(posedge clk) begin
        if (state == 3 && start_shifting && shift_data == 4'b1101) begin
            mismatch_count <= mismatch_count + 1;
        end
        sample_count <= sample_count + 1;
    end
    
    // Initialize the counters
    initial begin
        mismatch_count = 0;
        sample_count = 0;
    end
    
    // Display simulation results
    always @(posedge clk) begin
        if (sample_count == 643) begin
            $display("Simulation finished at %0d ps", $time);
            $display("Mismatches: %0d in %0d samples", mismatch_count, sample_count);
        end
    end

endmodule
